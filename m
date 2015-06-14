From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Midisport 2x2 Anniversary edition,
	latency	problem
Date: Sun, 14 Jun 2015 21:17:20 +0200
Message-ID: <557DD340.6020200@ladisch.de>
References: <1430209117.53049092@f91.i.mail.ru>	<1430230406.500088555@f412.i.mail.ru>
 <553FB37B.3000802@ladisch.de> <1430239699.153166263@f195.i.mail.ru>
 <554084BB.1090304@ladisch.de>
 <loom.20150614T205252-433@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 9AAA0260623
 for <alsa-devel@alsa-project.org>; Sun, 14 Jun 2015 21:18:15 +0200 (CEST)
In-Reply-To: <loom.20150614T205252-433@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier <olivier.pierre@voila.fr>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Olivier wrote:
> I think I have similar problem on Debian 8 Jessie, M-Audio Midisport 2x2
> Anniversary edition and a synth keyboard. In my case the midi works fine for
> a moment but after a moment, the latency is about 5 seconds. GMidi monitor
> linked to Jack monitors note events 5 seconds later...

Do you get the same delay when monitoring with amidi or aseqdump?


Regards,
Clemens
