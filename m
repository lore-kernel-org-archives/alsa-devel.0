From: Paul Davis <pbd@op.net>
Subject: Re: unitor8/amt8 driver for alsa 0.9.0rc1
Date: Wed, 01 May 2002 10:29:33 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205011428.g41ESJD23193@post2.fast.net>
References: <001001c1f100$4cab6700$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 01 May 2002 12:06:40 BST."
             <001001c1f100$4cab6700$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: Manush Dodunekov <manush@stendahls.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>A solution could be alter libasound to support non-kernel drivers. Or use
>a loopback device in the kernel. 

libasound *does* support non-kernel drivers. when you access

	  snd_{pcm,rawmidi}_foo (handle, ...)

what you're actually doing is:

     1) check the device type of handle
     2) use snd_pcm_TYPE_foo (handle, ...)

this is not done for every call - instead, when you open the handle,
the relevant function pointers are set up.

for example:

    snd_pcm_open (&handle, "hw:0,0", ...)

sets up the set of function pointers to use:

     snd_pcm_hw_read
     snd_pcm_hw_write
     snd_pcm_hw_prepare
     snd_pcm_hw_status

etc.

you can define a new device type in ~/.asoundrc that names specific
functions to be used for each part of the API. then you just add the
.so that contains the functions, and you're all set.

--p
