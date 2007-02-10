From: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Naming two identical USB devices (need help)
Date: Fri, 9 Feb 2007 21:25:45 -0500
Message-ID: <75b66ecd0702091825r24befd63tab99a9aa9c9df788@mail.gmail.com>
References: <1171060928.13387.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1171060928.13387.10.camel@localhost>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-1?Q?Jean-Michel_Pour=E9?= <jmpoure@free.fr>
Cc: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 2/9/07, Jean-Michel Pour=E9 <jmpoure@free.fr> wrote:
> Hello,
>
> My need is very basic.
>
> I am using two Terratec Aureon USB MK2 devices.
> But this could be any case where two devices are the same.
>
> My question is:
>
> Is there a way to make sure that each physical device always has the
> same name: plughw:0,0 (first identical card) and plughw:1,0 (second
> identical card). This would allow me to plug the cards and forget the
> plugs.
>

I don't think there's an easy way with any current Linux distro.

Don't USB devices have some kind of hardware serial number or GUID
that udev could be taught about?

Lee

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
