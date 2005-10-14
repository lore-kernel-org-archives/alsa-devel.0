From: Szekeres =?iso-8859-2?Q?Istv=E1n?= <szekeres@iii.hu>
Subject: Re: USB headset problem
Date: Sat, 15 Oct 2005 00:05:39 +0200
Message-ID: <20051014220539.GA1818@pulsussoft.hu>
References: <20051014091716.GA30524@pulsussoft.hu> <Pine.HPX.4.33n.0510141250040.23443-100000@studcom.urz.uni-halle.de> <20051014202153.GA1428@pulsussoft.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20051014202153.GA1428@pulsussoft.hu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2005 at 10:21:53PM +0200, Szekeres Istv=E1n wrote:
> Indeed. The microphone is really working. Now the only problem is that =
I
> tried it under skype (that's why I bought the headset), and under skype=
 it
> is not working at all (strace revealed that skype is writing 0s to the =
sound
> device) - so I'm afraid this problem is out of the scope of this mailin=
g
> list.

Ok, after some experimenting the results are the following:

- Using latest git version of the kernel -> skype is not working
- Using 2.6.12.5 -> skype is working
- Other apps are working in both versions.

How can I investigate why does not skype working in case of the git versi=
on?

Thanks,
Szekeres Istvan


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
