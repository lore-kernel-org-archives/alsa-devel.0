From: Szekeres =?iso-8859-2?Q?Istv=E1n?= <szekeres@iii.hu>
Subject: Re: USB headset problem
Date: Fri, 14 Oct 2005 11:22:10 +0200
Message-ID: <20051014092210.GA30614@pulsussoft.hu>
References: <20051014054335.GA29438@pulsussoft.hu> <20051014080026.GA27930@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051014080026.GA27930@palantir8>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> > I've just bought a "Gembird EHS-USB" headset (this is with a microphone).
> > Audio playback is OK, but recording is not. Applications do not find the
> > "capture channel". E.g. alsamixer shows only the PCM channel, but when I try
> > to switch to "capture view", it quits with:
> 
> In the dmesg output I could not see snd-usb-audio being loaded. Could you
> check with lsmod if that module gets loaded, and modprobe it if it is not
> loaded. Also, check if there is acapture device in /proc/asound/devices
> for this "card".

the module is loaded and the playback is fine. Only recording is a problem..

/proc/asound/devices:

 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture
 32: [1- 0]: ctl

> Could you post the output of "amixer"?

Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 128
  Front Left: Playback 128 [100%] [on]
  Front Right: Playback 128 [100%] [on]

Thanks,
Szekeres Istvan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
