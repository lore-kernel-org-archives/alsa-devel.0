From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1 works, alsa-driver-1.0.9rc2 doesn't
Date: Wed, 30 Mar 2005 23:00:04 +0100 (BST)
Message-ID: <20050330220004.1809.qmail@web52909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: 6667
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--- Lee Revell <rlrevell@joe-job.com> wrote:
> This is a known problem.  We have isolated it to something committed to
> CVS between 3-22 and 3-24 IIRC (check list archive).  I posted the "cvs
> diff" output.  We need someone to go though that patch and figure out
> which change is responsible.

I'm sure. But that someone would need to be able to divide that diff up i=
nto logically related
units such that each unit could be backed out, and the tree still expecte=
d to compile afterwards.

Cheers,
Chris


Send instant messages to your online friends http://uk.messenger.yahoo.co=
m=20


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
