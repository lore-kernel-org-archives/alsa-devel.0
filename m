From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: hdsploader installation bug(?)
Date: Wed, 10 Dec 2003 19:06:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33125.213.245.85.163.1071079613.squirrel@www.undata.org>
References: <200312102010.22255.Jaakko
        Prattala
        <>>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312102010.22255.Jaakko Prattala <>>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel@Lists.SourceForge.NET
List-Id: alsa-devel@alsa-project.org

> alsa cvs 9th Dec 2003 (late at night):
> hdsploader told me it could not find
> /usr/local/share/alsa/firmware/
>    hdsploader/multiface_firmware_rev11.bin
> I guess it didn't go to place with make install
> for some reason.
>
> # make install
> make[1]: Entering directory
> `/home/jaakko/downloads/alsaCVS_091203/alsa-tools/hdsploader'
> /bin/sh ./mkinstalldirs /usr/local/bin
>   /usr/bin/install -c hdsploader /usr/local/bin/hdsploader
> make[1]: Nothing to be done for `install-data-am'.
> make[1]: Leaving directory
> `/home/jaakko/downloads/alsaCVS_091203/alsa-tools/hdsploader'
>
> --
> Jaakko

The firmware files are no more shipped with alsa-tools, but in the
alsa-firmware package. Did you install this one ?

Thomas





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
