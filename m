From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ProVideo PV 918A - audi o device created but
 cannot capture sound
Date: Fri, 17 Jan 2014 09:47:45 +0100
Message-ID: <52D8EE31.4000304@ladisch.de>
References: <loom.20140117T085941-825@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id ECE8C261A7B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 09:47:49 +0100 (CET)
In-Reply-To: <loom.20140117T085941-825@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: siddharth <siddharth@greenearthnetwork.in>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

siddharth wrote:
> modprobe snd-bt87x load_all=1 digital_rate=48000 enable=1

You are telling the driver that the tuner chip has a digital output that
runs at 48 kHz, and this it is connected to the digital input pin of the
Bt878 chip.

> but am unable to capture sound.

Do you actually know that your hardware is constructed that way?

How exactly did you try to capture?  From which device?  (see "arecord -l")


Regards,
Clemens
