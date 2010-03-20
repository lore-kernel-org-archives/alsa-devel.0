From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Question about dmix?
Date: Sat, 20 Mar 2010 14:27:15 +0000
Message-ID: <ho2m03$1fs$1@dough.gmane.org>
References: <4df68b71003200705j36e71a8aicf9c44fb7f104c27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id A4B18243EB
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 15:27:32 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1NszeB-0007h1-7z
	for alsa-devel@alsa-project.org; Sat, 20 Mar 2010 15:27:27 +0100
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 15:27:27 +0100
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 20 Mar 2010 15:27:27 +0100
In-Reply-To: <4df68b71003200705j36e71a8aicf9c44fb7f104c27@mail.gmail.com>
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

'Twas brillig, and cee1 at 20/03/10 14:05 did gyre and gimble:
> Hi all,
> I know alsa support userspace software multi-playback by dmix plugin.
> How does it realize? I expected a daemon accepting multi-streams which
> then mixes these streams to a single one -- it seems not the case.

I believe an older version of dmix used to act like a daemon, but the
current version no longer does this and instead uses some magic spells
that I don't even being to know about.

As far as userspace mixing goes, most linux distros and a lot of
embedded systems (e.g. smartphones) now use PulseAudio which does run as
a stand alone daemon and opens a single stream to alsa. It does much
more than just mixing, but it fits in with your paradigms :)

See http://pulseaudio.org for more info.

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
