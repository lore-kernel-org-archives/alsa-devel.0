From: =?iso-8859-1?Q?S=E9bastien?= Hinderer <Sebastien.Hinderer@ens-lyon.org>
Subject: beeps with incorrect frequency / volume
Date: Fri, 16 Oct 2009 06:09:16 +0200
Message-ID: <20091016040916.GA3428@pema>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from toccata.ens-lyon.org (toccata.ens-lyon.fr [140.77.166.68])
	by alsa0.perex.cz (Postfix) with ESMTP id DDBDF2413B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 06:09:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by toccata.ens-lyon.org (Postfix) with ESMTP id 9A12D84082
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 06:09:41 +0200 (CEST)
Received: from toccata.ens-lyon.org ([127.0.0.1])
	by localhost (toccata.ens-lyon.org [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id pcyQYmhWJJh2 for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 06:09:17 +0200 (CEST)
Received: from pema.homeunix.org (136.139.91-79.rev.gaoland.net
	[79.91.139.136]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by toccata.ens-lyon.org (Postfix) with ESMTP id E0CFF8407D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Oct 2009 06:09:16 +0200 (CEST)
Received: from seb by pema.homeunix.org with local (Exim 4.69)
	(envelope-from <Sebastien.Hinderer@ens-lyon.org>) id 1Mye7w-0000tj-5M
	for alsa-devel@alsa-project.org; Fri, 16 Oct 2009 06:09:16 +0200
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA Developers,

The sound card of my laptop is a HDA Intel, chip Intel G45 DEVCTG
The PC beeps do not work correctly.
One problem is that the frequency of the beeps one can hear does not
correspond to the required frequency. For instane the command
beep 440
produces a beep whose frequency is not 440Hz
The second problem is that, although there is a PC beep control provided
in alsamixer, the control is not taken into account: the beep is loud no
matter how the control is set.

I think this problem has already been reported but can't find it in the
bug tracking system.

Could someone please help and tell me whether the problem can e solved
or not and, if it can, how.

Many thanks in advance for any help,
S=E9bastien.
