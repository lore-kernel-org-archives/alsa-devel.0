From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Lowest latency: JACK, or ALSA directly?
Date: Thu, 11 Nov 2004 15:41:53 +0100
Message-ID: <20041111144152.GA12443@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As I understand it, JACK acts as a middle layer between a (jack-aware)
application and the underlying ALSA libraries.  But it is also possible
to program against the ALSA libraries directly (which I am doing now).

I am writing an application for audio transfer over network, where the
main goal is to achieve the lowest latency possible.  I would assume
that, as JACK adds an extra layer, it may also introduce extra latency. =20
Is that so?  And in that case, how much may be gained by using the ALSA
libs directly, instead of going through ALSA?


Although I so far barely have gotten into ALSA programming, it does seem
to be manageable in difficulty. (Don't laugh, I am an acoustican, not a=20
programmer.)  How is programming against JACK in comparison?


As far as I understand it, the main advantages of JACK are the=20
possibility to connect together several applications, as well as the=20
ability to keep these applications in sync.  That is however not very=20
important to me now, as I will probably not need to connect to other=20
programs.  Are there other important advantages?  And what are the=20
disadvantages?


(As an aside, if anybody knows of any open source applications for very
low latency transfer of audio over IP, I would appreciate it if you let
me know.  Although this audio programming is some of the most fun I have=20
had in years, I can hardly defend spending my time duplicating work.)


With kind regards
Asbj=F8rn S=E6b=F8



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
