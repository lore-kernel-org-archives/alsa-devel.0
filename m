From: "Shakul  Arora, Noida" <shakula@noida.hcltech.com>
Subject: RE: Urgent Help needed
Date: Thu, 23 May 2002 09:43:29 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E04CF3F88ACBD5119EFE00508BBB212102C91E58@exch-01.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Juan Linietsky <coding@reduz.com.ar>
List-Id: alsa-devel@alsa-project.org

Thanks Juan, Takashi

Recently I wass going thru AC-97 Component specifications. It seems that it
is possible to bypass mux for MIC input and have two captures
simultaneously.(Section 5.5 pg 45 AC97 Component Specs). I don't know if it
supported by any driver.

Please if some one can send some documentation on mixer and groups. Was not
able to locate any good documentation on how these works.

Rgds
Shakul

-----Original Message-----
From: Juan Linietsky [mailto:coding@reduz.com.ar]
Sent: Wednesday, May 22, 2002 11:12 PM
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Urgent Help needed


On Wed, 22 May 2002 20:35:09 +0530
"Shakul  Arora, Noida" <shakula@noida.hcltech.com> wrote:

> Hi,
> 
> Please if you can help how can I program the device the "MIX" mode
> for both LINE IN and MIC capture. I accept that both the 
> inputs are to be capture in mono, in stero mode the quality will be
> bad.

Check either alsamixer or any other ALSA or OSS compatible mixer. on
the same global volume send sliders you should be able to also set the
record option. You should also play with the IGAIN slider to adjust
the input volume rate for recording. One of the things that surprised
me the most about the ensoniq 1371 cards is the amazingly clean ADC
compared to my other cards. If you have your computer and whathaver
you are using as input source well connected and properly grounded,
you should get no noise at all while recording. So far i've been using
it as cheap analog source recording, connected to a mixer, which has
connected a couple of synths, and the results were extremely good.


Regards


Juan Linietsky



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
