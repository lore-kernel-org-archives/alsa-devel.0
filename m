From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] ac97: Fix AD1819 PCM volume range
Date: Sun, 3 Sep 2006 05:15:12 +0300
Message-ID: <20060903021512.GA23081@sci.fi>
References: <20060903020753.090538831@proteus.korsu.shacknet.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20060903020753.090538831@proteus.korsu.shacknet.nu>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 03, 2006 at 05:07:54AM +0300, syrjala@sci.fi wrote:
> AD1819 PCM volume register can hold one extra bit per channel which do
> not affect the actual volume. Add a res_table to the codec patch to fix
> the problem.

Actually, scrap this patch. It looks like other controls suffer from the =

same problem. I'll send an updated patch shortly...

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
