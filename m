From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Tascam US-224/428 MMC: Work in progress...
Date: Tue, 27 Jul 2004 15:50:28 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <14675.195.245.190.93.1090939828.squirrel@195.245.190.93>
References: <33466.195.245.190.93.1089901175.squirrel@195.245.190.93>
    <7444.195.245.190.93.1090312112.squirrel@195.245.190.93>
    <20040720180512.GA527@tuba.home>
    <1861.195.245.190.93.1090402661.squirrel@195.245.190.93>
    <32829.192.168.1.5.1090718653.squirrel@192.168.1.5>
    <33252.192.168.1.8.1090884978.squirrel@192.168.1.8>
    <s5h1xix5ygj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040727155028_86816"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xix5ygj.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, martin-langer@gmx.de, annabellesgarden@yahoo.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

------=_20040727155028_86816
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Takashi,

>>
>> That's me again, now with another iteration of a modified us428control.
>> MMC support has been improved and transport LEDs is getting almost
>> functional. Tascam control protocol sysex decoding is also complete
>> (LEDs control mainly).
>>
>> As before, I'm only testing this on my US-224. US-428 owners should test
>> and report is everything is to their taste. Work is in progress...
>>
>
> Could you submit a patch instead of the whole tarball?
> It'll make easier to review the changes you made.
>
>

Sure. Here it goes. It even includes some last-minute updates since the
last tarball. It's almost final :)

Please note that the patch is being based on alsa-tools cvs tree, as of
2004-07-24.

Take care.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20040727155028_86816
Content-Type: application/x-gzip-compressed;
      name="us428control-0.4.2.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="us428control-0.4.2.patch.gz"

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
miw57m1F9vo1S7fYb+wYs5L/A46/J8QJUwAA
------=_20040727155028_86816--




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
