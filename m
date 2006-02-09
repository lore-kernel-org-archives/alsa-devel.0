From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/pci/ac97 ac97_codec.c,1.210,1.211
Date: Thu, 9 Feb 2006 14:06:04 +0000
Message-ID: <ad2655cb0602090606n3a3abeb4k@mail.gmail.com>
References: <E1F7AEn-00081s-QW@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1F7AEn-00081s-QW@sc8-pr-cvs1.sourceforge.net>
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
To: Takashi Iwai <tiwai@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 09/02/06, Takashi Iwai <tiwai@users.sourceforge.net> wrote:
> Update of /cvsroot/alsa/alsa-kernel/pci/ac97
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv30825/pci/ac97
>
> Modified Files:
>         ac97_codec.c
> Log Message:
> Summary: ac97 - Add support of static resolution tables
>
> Added the support of static resolution table support for codecs
> that the driver cannot probe the volume resolution properly.
>
> The table pointer should be set in each codec patch.
>

What are the details of how the probe fails?
I know of some AC97 chips that need the read after write to be done
twice before valid results come back for the probing. I have already
added extra reads into the probing code, so this specific problem
should not be the cause, but I would be interested to see if this
problem could be resolved without resorting to static tables.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
