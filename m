From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [linux-audio-dev] Alsa /dev/sequencer stuff
Date: Tue, 20 May 2003 00:47:41 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19HywJ-0002tc-00@sc8-sf-list1.sourceforge.net>
References: <000201c31e86$6cacf0f0$ac1f830a@ICO>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 20 May 2003 00:15:19 EDT."
             <000201c31e86$6cacf0f0$ac1f830a@ICO>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: linux-audio-dev@music.columbia.edu
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>In my app (RTMix) I will be soon implementing multiple midi-input device
>opens, so that the app can be controlled from as many of the midi
>controllers simultaneously as possible. One way of devising this was to
>design a separate thread for every open device (using raw midi /dev/midi
>etc., although I will be re-implementing that to use ALSA devices
>directly). 

although i've been a big advocate of using raw midi ports in the past,
i've pretty swung around on this issue. i think you should use the
ALSA sequencer API instead. that way you can connect applications to
each other, rather than just applications to h/w. same thinking as
JACK in this regard.

>	    However, this might not be the most elegant way of doing
>this, so what I was wondering is how does the /dev/sequencer correspond
>to this issue? I mean, does it work the same way like addressing the raw
>midi ports, are the message formats the same, and most importantly does
>one SINGULAR /dev/sequencer encompass all of the midi ports that are
>currently available?

no, just one port. the OSS sequencer /dev/sequencer is only a
scheduler - it has no routing capabilities at all.

the ALSA sequencer (/dev/snd/seq etc.) is a multiplexer/demultiplexer,
and handles both scheduling and routing, and covers all available h/w
ports and registered s/w clients.

don't leave home without it :)


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
