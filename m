From: Die Mumie <mumie_die@yahoo.de>
Subject: Re: New Realtec ALC833 Codec in Fujitsu Siemens Xi2428
Date: Wed, 5 Dec 2007 01:47:07 +0100 (CET)
Message-ID: <545048.2302.qm@web26715.mail.ukl.yahoo.com>
References: <1196813543.10030.92.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n10.bullet.re3.yahoo.com (n10.bullet.re3.yahoo.com
	[68.142.237.123]) by alsa0.perex.cz (Postfix) with SMTP id 8050F244BC
	for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2007 01:47:09 +0100 (CET)
In-Reply-To: <1196813543.10030.92.camel@razman.gruemaster.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA Developers List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Ok, well,
I already have tried all models for snd_intel_hda and none of them was sati=
sfying me... =


I run the script and the output is availible at http://pastebin.ca/806180 .
Thanks for helping

           No, this is as good a place as any to post.  We'll need a bit mo=
re info, though.  The easiest way to get the info is to run this script:  h=
ttp://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh
 =

 Post the link it generates back to this mailing list and either I or someo=
ne else can look into it.  Be patient, as it may take a week or two.
 =

 Also, try one of the supported models for the ALC883:
                3stack-dig    3-jack with SPDIF I/O
               6stack-dig    6-jack digital with SPDIF I/O
               3stack-6ch    3-jack 6-channel
               3stack-6ch-dig 3-jack 6-channel with SPDIF I/O
               6stack-dig-demo  6-jack digital for Intel demo board
               acer          Acer laptops (Travelmate 3012WTMi, Aspire 5600=
, etc)
               acer-aspire   Acer Aspire 9810
               medion        Medion Laptops
               medion-md2    Medion MD2
               targa-dig     Targa/MSI
               targa-2ch-dig Targs/MSI with 2-channel
               laptop-eapd   3-jack with SPDIF I/O and EAPD (Clevo M540JE, =
M550JE)
               lenovo-101e   Lenovo 101E
               lenovo-nb0763 Lenovo NB0763
               lenovo-ms7195-dig Lenovo MS7195
               haier-w66     Haier W66
               6stack-hp     HP machines with 6stack (Nettle boards)
               3stack-hp     HP machines with 3stack (Lucknow, Samba boards)
               auto          auto-config reading BIOS (default)
     =

  To test these confiugurations, unload and reload the driver with "modprob=
e -r snd-hda-intel && modprobe snd-hda-intel model=3D<model name>" (replace=
 <model name> with one from above - i.e. medion).
 =

 =

 =

 Tobin
 =

 On Tue, 2007-12-04 at 23:49 +0100, Die Mumie wrote:  =

Hi, I've been told to post here, so I do.  I have a Notebook with a Intel h=
da sound device, the /proc/asound/card0/codec#1 returns Realtec ALC833 but =
there is no model provided by the alsa driver that runs this Soundcard prop=
erly.  Am I wrong here? If yes, then I'm sorry.          ------------------=
--------------- Heute schon einen Blick in die Zukunft von E-Mails wagen? V=
ersuchen Sie=B4s mit dem  neuen Yahoo! Mail.  _____________________________=
__________________ Alsa-devel mailing list Alsa-devel@alsa-project.org http=
://mailman.alsa-project.org/mailman/listinfo/alsa-devel =

     --  Tobin Davis  =

 =

 =

This land is full of trousers!
this land is full of mausers!
 And pussycats to eat them when the sun goes down!
  -- Firesign Theater

    =


       =

---------------------------------
Ihre erste Baustelle? Wissenswertes f=FCr Bastler und Hobby Handwerker. =
