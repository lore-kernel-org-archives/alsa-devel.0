From: Oliver Schrempf <un1q@stud.uni-karlsruhe.de>
Subject: Re: asoundrc problem
Date: Tue, 28 Jan 2003 12:06:16 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301281203180.13531-100000@rzstud5.stud.uni-karlsruhe.de>
References: <s5hisw9mwbw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisw9mwbw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 28 Jan 2003, Takashi Iwai wrote:

> > Umpf, sorry. I just realized, that I had a mistake in asoundrc from
> > playing around with plug:multi.
> >
> > The error I get now from
> > arecord -Dmplug -c16 test.wav
> > as well as from
> > arecord -Dplug:multi -c16 test.wav
> >
> > is
> >
> > arecord: main:462: audio open error: No such file or directory
>
> did you still have your original definition of pcm.multi ?
> the setting above is additional one.

To avoid confusions, here my actual settings:
pcm.multi {
        type multi;
        slaves.a.pcm "hw:0,0,0";
        slaves.a.channels 8;
        slaves.b.pcm "hw:1,0,0";
        slaves.b.channels 8;
        bindings.0.slave a;
        bindings.0.channel 0;
        bindings.1.slave a;
        bindings.1.channel 1;
        bindings.2.slave a;
        bindings.2.channel 2;
        bindings.3.slave a;
        bindings.3.channel 3;
        bindings.4.slave a;
        bindings.4.channel 4;
        bindings.5.slave a;
        bindings.5.channel 5;
        bindings.6.slave a;
        bindings.6.channel 6;
        bindings.7.slave a;
        bindings.7.channel 7;
        bindings.8.slave b;
        bindings.8.channel 0;
        bindings.9.slave b;
        bindings.9.channel 1;
        bindings.10.slave b;
        bindings.10.channel 2;
        bindings.11.slave b;
        bindings.11.channel 3;
        bindings.12.slave b;
        bindings.12.channel 4;
        bindings.13.slave b;
        bindings.13.channel 5;
        bindings.14.slave b;
        bindings.14.channel 6;
        bindings.15.slave b;
        bindings.15.channel 7;
}
pcm.mplug{
        type plug
        slave.pcm "multi"
}




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
