From: Yiliang Bao <yiliangb@gmail.com>
Subject: What is the required accuracy of audio sampling rate?
Date: Tue, 16 Feb 2010 15:58:59 -0800
Message-ID: <e5baf3861002161558x1d36f74anf63c5db145762668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f171.google.com (mail-pz0-f171.google.com
	[209.85.222.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 05945103845
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 00:59:00 +0100 (CET)
Received: by pzk1 with SMTP id 1so5492970pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 15:58:59 -0800 (PST)
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

I have a PCI-e audio card that does not give very accurate sampling rate
(about -0.2% error, i.e., if I set the sampling rate to 8K, I got only 7984
samples per second on average). It caused various synchronization problems
in applications like gstreamer.

Since there will be some difference from one clock domain to another, I am
wondering if there is any defined tolerance on the sampling rate, and where
the right place is to correct this kind of error. I would really appreciate
if someone can point me to the related documents/links.

Thanks,
Yiliang
