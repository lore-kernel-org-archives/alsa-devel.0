From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Memory leaks in alsa-lib
Date: Tue, 26 Aug 2003 15:14:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xwud0zhla.fsf@users.sourceforge.net>
References: <Pine.LNX.4.44.0308261432320.29234-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308261432320.29234-100000@pnote.perex-int.cz> (Jaroslav
 Kysela's message of "Tue, 26 Aug 2003 14:33:44 +0200 (CEST)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

>>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND =20
>>  7148 mru       11   0 25160  27m 2740 S  0.0 12.4   0:00.08 tcvp    =20
>>=20
>> Now the man page for top tells me that "VIRT =3D SWAP + RES", so unles=
s
>> a negative amount has been swapped (what would that mean?), something
>> strange is going on.  The odd thing is that this happens only when I
>> use the ALSA output module.  Could it be that alsa-lib triggers some
>> bug somewhere in top, or in the kernel?  This seems a little unlikely,
>> though.
>
> I will try to investigate this problem.

I seems to be a kernel problem.  See my recent post to linux-kernel on
the subject for more details.

--=20
M=E5ns Rullg=E5rd
mru@users.sf.net


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
