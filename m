From: "Zhang wei" <zhangwei@vimicro.com>
Subject: how to combine mutil-channel in playback or capture?
Date: Fri, 22 Mar 2013 16:08:03 +0800
Message-ID: <6B947C8AC4195040A8C6876A496C644A0819563C@BJ-MAIL-04.vimicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vimicro.com (unknown [211.155.250.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A64326627C
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 09:08:08 +0100 (CET)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have already achieved the alsa-driver which can playback and capture func=
tion with two channel. =

My board based on ARM9 which have 3 ADC & 1 DAC in IIS bus and all of them =
shared the same BCLK and LRCK. The pins figure Like this:

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _________________
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 BCLK=A0=A0 |_________=
__
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0 LRCK=A0=A0 |_________=
__
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0 ADCDAT0 |___________
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0 ADCDAT1 |___________
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0 ADCDAT2 |___________
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0 DACDATA |___________
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |_______________|

Every ADCDATn(n=3D0,1,2) has two channel so the question is how can I get m=
ulti-channel audio data such as 4 or 6 in capture funciton? =



BR
