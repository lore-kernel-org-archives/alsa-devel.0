From: "Shakul  Arora, Noida" <shakula@noida.hcltech.com>
Subject: RE: Urgent Help needed
Date: Wed, 22 May 2002 20:35:09 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E04CF3F88ACBD5119EFE00508BBB212102C91CDC@exch-01.noida.hcltech.com>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Please if you can help how can I program the device the "MIX" mode for both
LINE IN and MIC capture. I accept that both the 
inputs are to be capture in mono, in stero mode the quality will be bad.

If you can refrence to some API calls and structures.

Rgds
Shakul

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Wednesday, May 22, 2002 7:38 PM
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Urgent Help needed


At Wed, 22 May 2002 15:37:06 +0530,
Shakul  Arora, Noida <shakula@noida.hcltech.com> wrote:
> 
> Hi All,
> 
> I'm using Audio PCI 1371.
> I need to know if I can program both MIC and LINE IN in capture mode
> simultaneously. IF yes how.

no, on ac97, you can use only one of the capture sources at the same
time.  (or, two single mono captures are possible by assiging left and
right channels to different sources.)

another possible solution is to capture from the "Mix" source, which
is the mixture of all playbacks, including mic and line-in.
however, the quality may be bad, and of course, the signals can be
contaminated by other routes.


Takashi

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
