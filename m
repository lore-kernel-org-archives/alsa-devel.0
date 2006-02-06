From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: list all available devices
Date: Mon, 06 Feb 2006 13:58:39 -0500
Message-ID: <1139252320.2791.295.camel@mindpipe>
References: <43E71617.9090101@gmx.de>
	 <Pine.LNX.4.58.0602061118060.20834@denise.shiny.it>
	 <1139248850.2791.261.camel@mindpipe> <43E79108.7050300@gmx.de>
	 <1139249612.2791.269.camel@mindpipe>  <874q3ce3vn.fsf@zebra.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <874q3ce3vn.fsf@zebra.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matthias =?ISO-8859-1?Q?K=F6nig?= <list@phasorlab.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-02-06 at 19:30 +0100, Matthias K=F6nig wrote:
> Hi,
>=20
> Lee Revell <rlrevell@joe-job.com> writes:
>=20
> > It's insane to expect every app to use 100 lines of code list to list
> > available PCMs.  It should be a single function call.
>=20
> Hmm, doesn't this exist already? What about this:
>=20
> int snd_names_list(const char *iface, snd_devname_t **list)
> Give a list of device names and associated comments for selected interf=
ace.=20
>=20

No, that's something different (and does not even work here):

$ aplay -n
ALSA lib names.c:173:(snd_names_list) cannot access
file /etc/asound.names
aplay: names_list:199: snd_names_list error: No such file or directory

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
