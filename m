From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: [Fwd:  Multiple cards.]
Date: Wed, 12 Jun 2002 19:16:59 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D071F9B.1090302@boosthardware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060408040900020609020600"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA22874
	for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2002 12:12:29 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060408040900020609020600
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I originally sent this to jackit-devel but it should probably be 
discussed on this list too.

--------------060408040900020609020600
Content-Type: message/rfc822;
 name="Re: [Jackit-devel] Multiple cards."
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: [Jackit-devel] Multiple cards."

X-Mozilla-Status2: 00000000
Return-Path: <jackit-devel-admin@lists.sourceforge.net>
Delivered-To: boosth-pshirkey@boosthardware.com
Received: (qmail 9516 invoked from network); 12 Jun 2002 08:53:00 -0000
Received: from usw-sf-fw2.sourceforge.net (HELO usw-sf-list2.sourceforge.net) (216.136.171.252)
  by -H with SMTP; 12 Jun 2002 08:53:00 -0000
Received: from usw-sf-list1-b.sourceforge.net ([10.3.1.13] helo=usw-sf-list1.sourceforge.net)
	by usw-sf-list2.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17I3tC-0001mf-00; Wed, 12 Jun 2002 01:54:02 -0700
Received: from www7.networkshosting.com ([66.96.128.106])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17I3sP-0002qT-00
	for <jackit-devel@lists.sourceforge.net>; Wed, 12 Jun 2002 01:53:13 -0700
Received: (qmail 9432 invoked from network); 12 Jun 2002 08:51:42 -0000
Received: from unknown (HELO boosthardware.com) (61.73.94.157)
  by -H with SMTP; 12 Jun 2002 08:51:42 -0000
Message-ID: <3D070D18.4050505@boosthardware.com>
From: Patrick Shirkey <pshirkey@boosthardware.com>
Organization: Boost Hardware
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
CC: "jackit-devel@lists.sourceforge.net"
 <jackit-devel@lists.sourceforge.net>
Subject: Re: [Jackit-devel] Multiple cards.
References: <Pine.LNX.3.96.1020609234513.20161B-100000@planck.clarku.edu> <E17HH98-0005Ai-00@usw-sf-list1.sourceforge.net> <20020610155238.E6051@ecs.soton.ac.uk> <3D06E569.6080305@boosthardware.com> <3D06F382.ED7BCC17@folkwang-hochschule.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
X-BeenThere: jackit-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: Discussions about the development of JACK <jackit-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=jackit-devel>
X-Original-Date: Wed, 12 Jun 2002 17:58:00 +0900
Date: Wed, 12 Jun 2002 17:58:00 +0900

Joern Nettingsmeier wrote:
> Patrick Shirkey wrote:
> 
>>Sorry if I have missed the answer to this.
>>
>>Why doesn't a running jackd allow me access to all the cards in my system?
>>
>>Currently I can only access one card at a time. Should I be using the
>>plughw layer in the .asoundrc file to fool jack into thinking they are
>>all one card or is it just not a possibility to use jack for more than
>>one card at a time if they are not sample synced?
>>
>>The reason I want to do this is so I can use my pro multi channel card
>>for playback to my external mixer and my consumer card as a headphones
>>playback device so that I can cue tracks in alsaplayer using two or
>>three mixer channels in ardour for each alsaplayer gui. Latency isn't
>>much of a prob for headphones at this point.
>>
>>I know I can do this if I only use one card but that means sacrificing
>>the headphones because my card has four channels not six. It seems a
>>shame as I do have two other cards giving me a total of four channels at
>>24bit/96KHz and 6 channels at 16bit/48KHz these latter ones currently
>>being redundant in a live situation.
>>
> 
> 
> i learned from jaroslav and takashi how to do that with a "multi" device
> (i.e. some .asoundrc voodoo). i posted it to lad/lau and alsa-dev under
> the subject 'Re: How to "connect" two audio devices with alsa?'. mark
> rages added it to the wiki at
> http://alsa.opensrc.org/index.php?page=TwoCardsAsOne.
> 
> still, as long as the cards are open, they *will* run out of sync. i
> don't understand all of it, but my guess is you'd have to stop the cards
> to be in sync again, i.e. the longer the session, the worse it gets.
> works for me, though.
> 
> 

In your example you don't say whether your cards have are stereo or mono 
  channels.

I get this ouput when starting jack

----
# jackd -R -v -d alsa -d ttable
jackd 0.33.0
Copyright 2001-2002 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

3475 waiting for signals
creating alsa driver ... ttable|1024|2|48000|swmon
ALSA: no playback configurations available
ALSA: cannot configure capture channel
cannot load driver module alsa
jack main caught signal 15
-----

Using the following in my .asoundrc file. I'm not sure if it is correct 
as card0 has two stereo pcm devices. I'm not sure whether they are being 
defined in the following or not.

Does

         slaves.a.channels 2

refer to the pcm devices

         eg. hw:0,0 and hw:0,1

or the first two mono channels available on card0?

         eg. left and right channels on hw:0,0

----
# create a virtual four-channel device with two soundcards:
# iiuc, this is in fact two interleaved stereo streams in
# different memory locations, so jack will complain that it
# cannot get mmap-based access. see below.

pcm.multi {
         type multi;
         slaves.a.pcm "hw:0,0";
         slaves.a.channels 2;
         slaves.b.pcm "hw:1,0";
         slaves.b.channels 1;
         bindings.0.slave a;
         bindings.0.channel 0;
         bindings.1.slave a;
         bindings.1.channel 1;
         bindings.2.slave b;
         bindings.2.channel 0;
#        bindings.3.slave a;
#        bindings.3.channel 1;
}
# i do not really understand what it means to have
# a ctl interface to a multi device. but jack will be
# unhappy if there is no mixer to talk to, so we set
# this to card 0.
ctl.multi {
         type hw;
         card 0;
}

# this creates a 4channel interleaved pcm stream based on
# the multi device. jack will work with this one.
pcm.ttable {
         type route;
         slave.pcm "multi";
         ttable.0.0 1;
         ttable.1.1 1;
         ttable.2.2 1;
#        ttable.3.3 1;
}
# see above.
ctl.ttable {
         type hw;
         card 0;
}
----
-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
_______________________________________________
Jackit-devel mailing list
Jackit-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/jackit-devel



--------------060408040900020609020600--


_______________________________________________________________

Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
