From: Petar Petkoff <tihomiroff@yahoo.com>
Subject: "Buffer overrun" problem
Date: Wed, 7 May 2003 01:42:18 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030507084218.82861.qmail@web11503.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tihomiroff@yahoo.com
List-Id: alsa-devel@alsa-project.org

    Hi,
    Before a half year I wrote a simple capture daemon,
using ALSA driver and lib ver. 0.9.0rc2. It works perfect...
    Before a week or more I tried my old code with ALSA 
driver and lib ver. 0.9.2, and some older: 
	0.9.0rc3
	0.9.0rc8
	0.9.0rc8a
	0.9.0rc8b
	0.9.0rc8d
    And the capture program doesn't work... 
    Buffer Overrun!
    
    I have tested with this sound cards:
	C-Media CMI8738 (snd-cmipci.o)
	Creative PCI 128 ENS1371 (snd-ens1371.o)
	Embedded sound in Intel 815 and later with 845EP (snd-intel8x0.o)

    Here I'll paste functions and ONLY most improtant params...
    
    snd_pcm_hw_params_alloca
    snd_pcm_open
    snd_pcm_hw_params_any
    snd_pcm_hw_params_set_access           (SND_PCM_ACCESS_RW_NONINTERLEAVED)
    snd_pcm_hw_params_set_format           (SND_PCM_FORMAT_U8)
    snd_pcm_hw_params_set_rate_near        (8000)
    snd_pcm_hw_params_set_channels         (2)
    max_buf = snd_pcm_hw_params_get_buffer_size_max
    snd_pcm_hw_params_set_buffer_size      (max_buf)
    snd_pcm_hw_params
    pcm_return = snd_pcm_readn             (max_buf)
    if (pcm_return < 0) { snd_pcm_prepare(); /* Buffer Overrun */}
    
    and snd_pcm_readn function returns value -5
    
    I tried with different cards and different value for buffer_size. 
I found the values for buffer_size, when the program works without 
buffer overruns...
But I've lost compatibillity with cards, which I want to use.

    Where is the problem?
    
10x in Advance
Petar T. Petkoff


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
