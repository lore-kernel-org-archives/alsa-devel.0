From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Does USB driver support IEC958?
Date: Tue, 11 Jan 2005 09:06:02 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0501110903240.12452-100000@studcom.urz.uni-halle.de>
References: <92C0412E07F63549B2A2F2345D3DB515F7D5EC@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D5EC@cm-msg-02.cmedia.com.tw>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Tien,  C.L. - =A5=D0=A9=D3=C2=A7 wrote:
> Did ALSA USB audio driver support IEC958 for input/output?

Yes.  Analog and digital inputs/outputs work the same, so the driver
doesn't even know what kind it is.


HTH
Clemens



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
