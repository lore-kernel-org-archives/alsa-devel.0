From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: USB quattro testing
Date: Wed, 28 May 2003 04:18:02 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED3B9EA.2000500@boosthardware.com>
References: <E19Kdq6-0007W3-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

I have been testing with an intel8x0 running into the quattro while
running all the four inputs. Input 3 and 4 started off working but after
killing off jack and rm /tmp/jack a few times it has become impossible
to get sound out of it with either alsa or jack even though the intel8x0 
was still functional.

This is the jack comandline as root with lowlatency on.

jackd -v -R -a -d alsa -d q4b -r 44100 -p 4096 -n3

Testing with jack only through i/o 3,4 I get a crystal clear sound.

The usb-audio driver has lost the ability to read the first two channels 
completely, replacing them with white noise and the multi or route 
plugins don't want to play nicely with jack even though this device is 
sample synced.

I tested recording with jackrec and got a lot of audio dropouts while
playing. I then used alsaplayer running with the input plugin and that 
was interesting. It gave the audio stream more of a pumping sound which 
was also adjustable by the pitch control so I could get a nice warped 
effect going. It wouldn't stand up to live recording but it could be fun 
to play with.

After rebooting and mounting /tmp instead of /tmp/jack (as well as 
spending two or three hours trying to get it back before hand). I am 
currently listening with ams in a direct loop and it sounds the same as 
alsaplayer input. This is a good recording of what I get using a sine 
wave through inputs 3,4 recorded with the ams wave output while using 
2in,4out.

	http://www.djcj.org/audio/test/052703-amsrec-4i2o.wav

This is with arecord -f cd for inputs 1,2:

	http://www.djcj.org/audio/test/052703-arec-2a.wav

=============
pcm.quattro {
         type multi;

         slaves.a.pcm "hw:2,0";
         slaves.a.channels 2;
         slaves.b.pcm "hw:2,1";
         slaves.b.channels 2;
	

          bindings.0.slave a;
          bindings.0.channel 0; # left
          bindings.1.slave a;
          bindings.1.channel 1; # right
          bindings.2.slave b;
          bindings.2.channel 0; # left
          bindings.3.slave b;
          bindings.3.channel 1; # right
	
}
ctl.quattro {
         type hw;
         card 2;
}

pcm.q4b {
         type route;
         slave.pcm "quattro";
         ttable.0.0 1;
         ttable.1.1 1;
         ttable.2.2 1;
         ttable.3.3 1;

}

ctl.q4b {
      type hw;
         card 2;
}
===================





-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No!
We want normal music!", I think that was more like acting than anything
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
