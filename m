From: Tom Yan <tom.ty89@gmail.com>
Subject: [Bug] [oxygen] Left/Right volumes de-sync when changed
	fast
Date: Thu, 3 Jan 2019 20:25:47 +0800
Message-ID: <CAGnHSEnBGhV9Xx9MUCtq4F-3subimEzUb1rup6-m-9Tco2kfFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi all,

This is actually quite a long-time issue as far as I am aware of.

My card is Xonar Essence STX. There is no problem when I change the
volume in alsamixer. The problem occurs when I bind
XF86Audio{Raise,Lower}Volume (a volume wheel on my keyboard) to
amixer commands. Volumes of the two channel can easily de-sync from
each other as long as I roll the wheel (up or down) fast. The problem
doesn't occur if the commands target volume control of a onboard or
USB sound card (even while their control allows different volumes for
the two channels).

Regards,
Tom
