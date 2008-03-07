From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: ALSACTL wrong restore on ARM9
Date: Fri, 7 Mar 2008 16:11:58 +0100
Message-ID: <49475.5288739272$1204902781@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 0EBD12460E
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 16:12:04 +0100 (CET)
Content-Language: fr
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

Hi list,

I'm using an intern AT91SAM92620-EK board with a WM8900 codec.
ALSACTL restores bad values to controls after doing this : 

$ rm /var/lib/alsa/asound.state
$ alsactl store
$ alsactl restore

Anyone has seen this issue before ?
Any ideas to solve it ? (I don't know much these utils neither alsa API)
Could it come from our ASoC codec driver ?

Thanks in advance.

Regards,
Alex.
