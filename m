From: "Bill Adair" <adair@gotadsl.co.uk>
Subject: Re: Linux 2.6.10 OOPS
Date: Fri, 21 Jan 2005 10:25:00 -0000
Message-ID: <opskx67ys8n0kn27@biotracedesign.com>
References: <41E63A75.1020107@vidsoft.de> <s5hzmzda9iu.wl@alsa2.suse.de> <41E65427.1020808@vidsoft.de> <s5hu0pla6u6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0pla6u6.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm suffering from a hard lockup as well but on an earlier kernel build
2.6.5 with SuSE patches. I've compiled down the kernel when spinlock =20
debugging
and debug code AND set nmi_watchdog but my SMP system still locks up. To =
=20
get
ALSA to run with this set up I had to remove a lot of lines checking for
current->fs->root which cause a system crash as the process I seem to be
running in _DOES NOT_ have fs set. I can't quite see the point of the lin=
es
which occur before calls to request->module.
Bill

On Thu, 13 Jan 2005 12:47:45 +0100, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 13 Jan 2005 11:57:43 +0100,
> Gregor Jasny wrote:
>>
>> Takashi Iwai wrote:
>> >>After removing an USB webcam with a built-in microphone =20
>> (snd-usb-audio)
>> >>the kernel oopsed and the PS/2 keyboard wasn't working anymore.
>> >
>> > Yeah this is a known problem.  This seems to be introduced recently.
>> > IIRC, it didn't happen with the USB stack on 2.6.9.
>>
>> At least on Fedora Core 3 with 2.6.9-1.667 it is happening, too.
>>  From a posting on the PWC mailing list:
>>
>>  > I'm using FC3 with kernel version  2.6.9-1.667 and no other
>>  > usb devices (in fact no other external devices) on a an
>>  > ibm thinkpad t42 laptop.
>
> Hmm, was 2.6.8 OK?
>
>
> Takashi
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



--=20
Ty Rhos Barn


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
