From: =?UTF-8?B?SWdvciBLb3RyYXNpxYRza2k=?= <ikk_pl@yahoo.co.uk>
Subject: OSS virtual driver - dma buffer size problems
Date: Wed, 29 Jan 2014 15:47:19 +0100
Message-ID: <52E91477.6050700@yahoo.co.uk>
References: <mailman.1317.1390977963.844.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm1.bullet.mail.ir2.yahoo.com (nm1.bullet.mail.ir2.yahoo.com
 [212.82.96.32]) by alsa0.perex.cz (Postfix) with ESMTP id CECD62617AA
 for <alsa-devel@alsa-project.org>; Wed, 29 Jan 2014 15:47:20 +0100 (CET)
In-Reply-To: <mailman.1317.1390977963.844.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Resolved. Used snd_pcm_hw_constraint_minmax.
