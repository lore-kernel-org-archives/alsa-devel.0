From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: nforce2 spdif and ogg123
Date: Sat, 18 Oct 2003 10:17:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310181417.h9IEHJW8025213@oud.linuxaudiosystems.com>
References: <1066481042.1386.10.camel@debian.dhs.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sat, 18 Oct 2003 14:44:02 +0200."
             <1066481042.1386.10.camel@debian.dhs.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gunther Laure <gunnar2@sbox.tu-graz.ac.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I followed the discussion: "optical SPDIF output on Abit NF7 nforce2
>main board".
>
>I am using a similar Epox Mainboard with SPDIF in/out. Currently i am
>using the todays cvs alsa version and have two questions:
>
>Using gqmgeg which uses ogg123 to play ogg files, ogg123 seems to have
>the samplerate (48kHz) problem mpg321 had in the above discussion.
>What is my chance to reduce the play speed. Alsaplayer works fine, but
>as it is not embeddable in gqmpeg its not an option. Maybe it is
>possible to define the samplerate in .asoundrc ?

did you make sure that you were using the plughw device? its possible
that for various reasons the hw device can't support the desired
sample rate, and if gqmpeg is anything like a lot of this code, it
doesn't check to see that the rate was set correctly.



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
