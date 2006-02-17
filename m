From: Paulo Matias <syscoder@gmail.com>
Subject: Re: Re: Test model
Date: Fri, 17 Feb 2006 10:57:00 -0200
Message-ID: <acb0c1690602170457l5335e137vf3db87bdc7f3857e@mail.gmail.com>
References: <200602170159.k1H1xYkI018018@auster.physics.adelaide.edu.au>
	 <43F5BC71.6040404@akl.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <43F5BC71.6040404@akl.lt>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rimas Kudelis <rq@akl.lt>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(Copy only of the body of the email I sent to Jonathan with the files)

Hi Jonathan,

These are the files of which I've said. I've diffed the .inf files at
the WDM directory and their differences are not in the part that
describes the codec pins, so I think I was wrong.

But, hey, I've looked better at the driver files and found an
AzMixerSel.ini. This file has clsids associated with mixer controls,
like this:

[008F1025&Dev0_{0A8C1AA2-42B0-11D2-95D2-00C04FB925D3}]
Name=3DMaster Volume
DeviceName=3DRealtek HD Audio output
Volume=3D32845
Mute=3D0
SelectMode=3D0

I've installed the driver in my Wine and then looked for these clsids
in the drive_c directory of Wine, and found only one binary file that
references all these clsids: windows/system32/drivers/RtkHDAud.Sys.

I suspect all the manufacturers use the same driver provided by
Realtek and then change the AzMixerSel.ini for adjusting the internal
routings.

Now, how can we know what clsid refers to what?

1. by comparision with models we already know the routings, like Fujitsu
2. by contacting Realtek
3. maybe by reverse engineering?

Regards,
Paulo Matias


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
