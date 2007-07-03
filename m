From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Remove dynamic configuration from alsa-lib
Date: Tue, 03 Jul 2007 16:11:58 -0300
Message-ID: <468A9F7E.3030806@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id BB6E610383D
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 21:13:06 +0200 (CEST)
Received: from dexter.tse.gov.br (localhost.tse.gov.br [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 7E0C0FCDDA
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 16:13:04 -0300 (BRT)
Received: from webmail.tse.gov.br (webmail.tse.gov.br [10.28.1.25])
	by dexter.tse.gov.br (Postfix) with ESMTP id 64B9CFCDDD
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 16:13:03 -0300 (BRT)
Received: from webmail.tse.gov.br (localhost.localdomain [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id 41B9614C11F
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 16:13:03 -0300 (BRT)
Received: from [10.28.219.33] (unknown [10.28.219.33])
	by webmail.tse.gov.br (Postfix) with ESMTP id 37B6714C11E
	for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2007 16:13:03 -0300 (BRT)
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

I have a hard job...to remove dynamic configuration from alsa-lib 
(conf.c,confmisc.c).
I found it difficult because snd_conf_* functions are spread all over 
*.c files.
Is there am easy way of doing it ? Does anyone have some "guidelines" of 
doing it?
Any help is wellcome...
Fausto Carvalho Marques Silva
