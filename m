From: Johannes Kimmel <johannes.kimmel@gmx.de>
Subject: STAC92xx model problem on HP EliteBook 8740w
Date: Fri, 29 Apr 2011 23:26:20 +0200
Message-ID: <4DBB2CFC.70002@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.22])
	by alsa0.perex.cz (Postfix) with SMTP id EC5A7103A2E
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 23:26:48 +0200 (CEST)
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

Hi,

I hope this is the right location for my problem.
When don't specify the model for my soundcard, everything works except 
spdif output over displayport. Correct led status, control names etc. 
working fine.
But when I want to use sound over displayport, one working option is 
model=rev, but then my laptop-speakers don't work anymore.

I think there is maybe a right model missing, or at least I didn't find 
the right.

Here are 2 alsa-infos:

spdif working:
http://paste.pocoo.org/show/380474/

laptop-speaker working:
http://paste.pocoo.org/show/380473/

I compile my kernel myself and I know the way to the alsa-drivers. So if 
there's anything to try that might help solve the problem, just ask.

Johannes Kimmel
