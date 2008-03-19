From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Buffer management in ALSA
Date: Wed, 19 Mar 2008 08:36:06 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A088058D4D70@dbde01.ent.ti.com>
References: <mailman.3514.1205879646.2095.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from soda.ext.ti.com (soda.ext.ti.com [198.47.26.145])
	by alsa0.perex.cz (Postfix) with ESMTP id D444B24560
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 04:09:16 +0100 (CET)
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m2J39Ajt027862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 22:09:15 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m2J3996I013499
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 22:09:09 -0500 (CDT)
Received: from dbde01.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id m2J396jM016918
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 22:09:08 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <mailman.3514.1205879646.2095.alsa-devel@alsa-project.org>
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

Hi All,

Can anyone throw some light on the buffer management part in the ALSA
framework? How and where it is implemented? And what is expected from
the driver, which is hooking its code to the framework?

Thanks in advance,
Anuj Aggarwal
