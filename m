From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM format restrict dilema
Date: Tue, 16 Sep 2003 16:11:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309162011.h8GKBeKF014750@oud>
References: <3F676332.1000503@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 16 Sep 2003 20:23:30 BST."
             <3F676332.1000503@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> why don't you set the sizes based on frame counts, not time? i suspect
>> you're more likely to get better results.
>
>If the api for setting based on time it present, I would expect to be 
>able to use it.

you can use it. but the thing is that you are probably requesting
times in msecs, whereas almost all PCI audio interfaces only have
periods and buffers sizes that are measured in frames.

this means you will likely never get the buffer size you asked
for. its kind of like asking for 3 pounds of cheese in a store that
only measures in kilograms. if you're happy with the approximation
that will result, go ahead. otherwise, figure it out in the "correct"
units.

otoh, for USB audio, its arguably better to use msecs. sigh :)

>> i hope you handle the failure to get buffer_size/8 properly ... you
>> need to be willing to go all the way to buffer_size/2 before
>> concluding that you can't configure the device.
>
>I would expect to be able to use the "set_period_size_near" with 
>direction +1, so if period_size=buffer_size/8 did not work, the alsa-lib 
>would automatically select the next best one, even if it is 
>buffer_size/2, but this seems to fail as well.

it may be that alsa-lib considers certain "distances" as too great to
be considered "near". however, i would agree with you that it should
work. on the other hand, if you ask for 8 periods/buffer *or more*,
this will definitely fail on many audio interfaces, since they can
only offer less. keep in mind the "direction" argument to
set_foobar_near.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
