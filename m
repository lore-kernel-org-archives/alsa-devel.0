From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Tue, 08 Aug 2006 20:23:35 +0200
Message-ID: <20060808202335.1ypdlgq4tckkcwg4@webmail.supelec.fr>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155056548.23266.267914050@webmail.messagingengine.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


>> In this configuration I was able to connect and get some sound through
>> the 24-Bit mode. But the sound seems to be a little bit scrambled up.
>> One chanel has only a bit of the propper sound with very high
>> distortion and the other channel has almost the right sound. But also
>> higher distortion than in 16-Bit mode.
>>
>> Does any body know this sort of problems? Maybe another device has a
>> similar problem.
>
> Some other M-Audio USB devices use big-endian samples.

It might not be only a problem with BigEndian devices.

For instance I had to introduce the device_setup module parameter in 
order to make my Audiophile USB pre-select 16bits OR 24bits mode 
because switching between the two modes while the device is turned on 
doesn't work: In fact there is a 3 bytes sample sequence such as A-B-C 
D-E-F is read B-C-D E-F-G leading to a highly distorted sound.

If it turned out to be the same issue, you should add a quirk 
equivalent to the one I introduced for the Audiophile-USB device (See 
the Audiopghile-USB.txt docs from the docs directory for details).

Regards,
Thibault


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
