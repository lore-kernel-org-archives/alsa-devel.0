From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Please remove documentation pointer
Date: Mon, 15 Jul 2002 17:53:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0207151752530.24711-100000@mailserver.intern.bfad.de>
References: <3D32ECCD.5060203@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D32ECCD.5060203@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Tobias Peters <tpeters@uni-oldenburg.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> 
> Not true.
> 
> Paul said that the document clearly states that it is unfinished and I 
> said if you make any changes I will fix the document and put it up on 
> the alsa server directly.
> 
> The document has a lot of useful info but has become outdated.
>   If you know what the problems are then submit a fix.


I did:

Date: Mon, 3 Jun 2002 21:47:07 +0200 (CEST)
From: tomasz motylewski <tom@bfad.de>
To: pbd@users.sourceforge.net
Subject: wrong snd_pcm_open example code.


On http://www.op.net/~pbd/alsa-audio.html#captureex you wrote:

capture_handle = snd_pcm_open (argv[1], SND_PCM_STREAM_CAPTURE, 0)

The real ALSA9 API is 

err = snd_pcm_open(&chandle, cdevice, SND_PCM_STREAM_CAPTURE, 0)

Could you please currect this?

In my opinion example programs are the best form od documentation, but not
working examples are the worst form of misinformation.

------------------

No answer.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
