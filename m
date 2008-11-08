From: LCID Fire <lcid-fire@gmx.net>
Subject: Some questions on snd_kontrol_new
Date: Sat, 08 Nov 2008 12:50:42 +0100
Message-ID: <49157D12.8060305@gmx.net>
References: <1226144189.6872.2.camel@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1BA101037EE
	for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2008 12:50:44 +0100 (CET)
In-Reply-To: <1226144189.6872.2.camel@thinkpad>
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

Could someone get me some insight into the snd_kontrol_new?
I'm especially interested in the "private_value" and "index" field. At
least in usb_mixer.c it seems to me like private_value is used as the
index!? If that's the case, when should index be used and when
private_value?
Is there any special convention for the string of "name" field?
