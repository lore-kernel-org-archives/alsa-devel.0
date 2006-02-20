From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Re: Test model
Date: Mon, 20 Feb 2006 11:14:51 +1030 (CST)
Message-ID: <200602200044.k1K0ipOl023282@auster.physics.adelaide.edu.au>
References: <acb0c1690602170457l5335e137vf3db87bdc7f3857e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <acb0c1690602170457l5335e137vf3db87bdc7f3857e@mail.gmail.com> from "Paulo Matias" at Feb 17, 2006 10:57:00 AM
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paulo Matias <syscoder@gmail.com>
Cc: Rimas Kudelis <rq@akl.lt>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Paulo

> But, hey, I've looked better at the driver files and found an
> AzMixerSel.ini. This file has clsids associated with mixer controls,
> like this:
> 
> [008F1025&Dev0_{0A8C1AA2-42B0-11D2-95D2-00C04FB925D3}]
> :
>
> I've installed the driver in my Wine and then looked for these clsids
> in the drive_c directory of Wine, and found only one binary file that
> references all these clsids: windows/system32/drivers/RtkHDAud.Sys.
> 
> I suspect all the manufacturers use the same driver provided by
> Realtek and then change the AzMixerSel.ini for adjusting the internal
> routings.

That would make sense.

> Now, how can we know what clsid refers to what?

It's probably a little tricky as you've eluded to.  I particular, we want
to know the NIDs of these controls.  We can eliminate a lot of the clsid
parts just by comparison though.

The "Wave" has a clsid of DFF21FE4-F70F-11D0-B917-00A0C9223196.
The "CD player" has clsid DFF220E3-F70F-11D0-B917-00A0C9223196.

>From these two se can see that the only differences between the two occur
in the first 8 characters (presumedly describing the first 4 bytes of
something).  Therefore *if* the clsid itself contains any information about
the NIDs I would expect it to be in this first section.

I then note the following:

  Dev 0 Mic Volume: 0A8C1A8D-42B0-11D2-95D2-00C04FB925D3
  Dev 0 Mic Volume: 185FEDED-9905-11D1-95A9-00C04FB925D3
  Dev 1 Mic Volume: 0A8C1A8D-42B0-11D2-95D2-00C04FB925D3
  Dev 1 Mic Volume: 185FEDED-9905-11D1-95A9-00C04FB925D3

If the clsids were in some way describing the NIDs and other things I cannot
work out why the mic volume would appear twice with two quite different
clsids.  Furthermore, I note the clsid for Dev 0 mic and Dev 1 mic are the
same.  This last point almost guarantees that the clsid itself does not
contain the NID information.  If it *is* used to get information about what
controls to offer I suspect it is used to allow the driver to make an
indirect lookup of the info.

So in summary I don't think this file is going to provide any clues.  It
was a good idea though.

Regards
  jonathan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
