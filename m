From: Ludwig Schwardt <schwardt@sun.ac.za>
Subject: Multiple Delta 1010LT woes: UPDATE
Date: Fri, 20 Feb 2004 20:29:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4036521E.9070407@sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi again,

I've made some progress on the .asoundrc issue. I can now record 8 
analog channels in JACK using a single Delta 1010LT piped through the 
multi plugin. I cannot get playback to work yet. This is luckily not a 
problem for my application, which only records sound. Any ideas on 
getting playback to work?

I do notice a few extra warnings popping up which wasn't there when I 
accessed the soundcard directly, namely "late driver wakeups" followed 
by e.g. "delay of 46411.000 usecs exceeds estimated spare time of 
45230.000; restart ...". These delays are always very close to the 
estimated spare time. Since I cannot playback within JACK, I cannot tell 
whether this has an audible effect. Should I be worried?

I attach my .asoundrc for everyone else who struggles with this issue.
Hopefully I can just uncomment the commented blocks when the other 
Deltas arrive... Any remarks would be very helpful (for example, do I 
understand bindings and ttables correctly in my comments below?).

By the way, I started JACK with "jackd -R -d alsa -d jackmulti -C". It 
becomes unhappy if you leave out the -C flag.

Thanks and sorry for all the nagging questions,

Ludwig Schwardt

P.S. What is the rule regarding slaves.xxx.channels in multi plugins? It 
seems you have to set this equal to the actual number of channels of the 
soundcard (slaves.xxx.pcm) to prevent "invalid argument" and "broken 
configuration" ALSA errors. What do you choose if the number of capture 
and playback channels differ?

----------------------------------------

# START OF .asoundrc

# Alias for first Delta card
pcm.delta1010_1 {
    type hw
    card 0
}
ctl.delta1010_1 {
    type hw
    card 0
}

# Alias for second Delta card
#pcm.delta1010_2 {
#   type hw
#   card 1
#}
#ctl.delta1010_2 {
#   type hw
#   card 1
#}

# Alias for third Delta card
#pcm.delta1010_3 {
#   type hw
#   card 2
#}
#ctl.delta1010_3 {
#   type hw
#   card 2
#}

# Create virtual device out of multiple soundcards.
# This cannot be used by JACK, which will complain that it
# cannot get mmap-based access. See jackmulti below.
pcm.multi {
     type multi
     # First soundcard associated with slave "a"
     slaves.a.pcm delta1010_1
     # This must be specified, and MUST equal 12 for the Delta 1010LT
     # (otherwise "broken configuration" and "invalid argument" errors 
result)
     # I assume it must be equal to the correct number of channels on
     # other soundcards too
     slaves.a.channels 12
#    slaves.b.pcm delta1010_2
#    slaves.b.channels 12
#    slaves.c.pcm delta1010_3
#    slaves.c.channels 12

     # Read the lines below as follows:
     # bindings.x.slave y
     # bindings.x.channel z
     # The above example means:
     # "Bind channel z on slave y to channel x of the new multi device"
     # Check above to see which soundcard is associated with which slave

     # The first 8 channels of the first soundcard
     bindings.0.slave a
     bindings.0.channel 0
     bindings.1.slave a
     bindings.1.channel 1
     bindings.2.slave a
     bindings.2.channel 2
     bindings.3.slave a
     bindings.3.channel 3
     bindings.4.slave a
     bindings.4.channel 4
     bindings.5.slave a
     bindings.5.channel 5
     bindings.6.slave a
     bindings.6.channel 6
     bindings.7.slave a
     bindings.7.channel 7

     # The first 8 channels of the second soundcard
#    bindings.8.slave b
#    bindings.8.channel 0
#    bindings.9.slave b
#    bindings.9.channel 1
#    bindings.10.slave b
#    bindings.10.channel 2
#    bindings.11.slave b
#    bindings.11.channel 3
#    bindings.12.slave b
#    bindings.12.channel 4
#    bindings.13.slave b
#    bindings.13.channel 5
#    bindings.14.slave b
#    bindings.14.channel 6
#    bindings.15.slave b
#    bindings.15.channel 7

     # The first 8 channels of the third soundcard
#    bindings.16.slave c
#    bindings.16.channel 0
#    bindings.17.slave c
#    bindings.17.channel 1
#    bindings.18.slave c
#    bindings.18.channel 2
#    bindings.19.slave c
#    bindings.19.channel 3
#    bindings.20.slave c
#    bindings.20.channel 4
#    bindings.21.slave c
#    bindings.21.channel 5
#    bindings.22.slave c
#    bindings.22.channel 6
#    bindings.23.slave c
#    bindings.23.channel 7
}
# JACK requires a ctl (mixer) interface for any pcm interface
# it uses. A ctl interface for a multi device is a bit strange,
# but set this to the mixer of the first soundcard to keep JACK happy.
ctl.multi {
     type hw
     card 0
}
				
# This creates a multi-channel interleaved PCM stream based on
# the multi device. JACK will work with this one, as it can get
# mmap access to the channels.
pcm.jackmulti {
     type route
     slave.pcm multi

     # As I understand it, you read "ttable.x.y z" as "route channel y of
     # slave device specified above to channel x of the new (client) 
device,
     # and multiply signal along this route with factor z", where z is
     # between 0.0 and 1.0. A value of 1.0 therefore indicates no change to
     # the signal (a straight routing between channels).
     ttable.0.0 1.0
     ttable.1.1 1.0
     ttable.2.2 1.0
     ttable.3.3 1.0
     ttable.4.4 1.0
     ttable.5.5 1.0
     ttable.6.6 1.0
     ttable.7.7 1.0

#    ttable.8.8 1.0
#    ttable.9.9 1.0
#    ttable.10.10 1.0
#    ttable.11.11 1.0
#    ttable.12.12 1.0
#    ttable.13.13 1.0
#    ttable.14.14 1.0
#    ttable.15.15 1.0

#    ttable.16.16 1.0
#    ttable.17.17 1.0
#    ttable.18.18 1.0
#    ttable.19.19 1.0
#    ttable.20.20 1.0
#    ttable.21.21 1.0
#    ttable.22.22 1.0
#    ttable.23.23 1.0
}
# JACK requires a ctl (mixer) interface for any pcm interface
# it uses. This is set to the first soundcard to keep JACK happy.
ctl.jackmulti {
     type hw
     card 0
}

# END OF .asoundrc



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
