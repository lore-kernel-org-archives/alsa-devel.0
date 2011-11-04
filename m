From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Re: aplay - memory leak
Date: Fri, 4 Nov 2011 18:31:41 +0530
Message-ID: <CAODvfaG7TGOZB6poE+T+JkHayxx_o+v0MN0944GD_Bt=Xx27dw@mail.gmail.com>
References: <CAODvfaHcmA2UzqG12iNwoUrxoLG1ftN_x37VTyvT6xf0133zYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 044E72482A
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 14:01:44 +0100 (CET)
Received: by gyg4 with SMTP id 4so2625718gyg.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2011 06:01:41 -0700 (PDT)
In-Reply-To: <CAODvfaHcmA2UzqG12iNwoUrxoLG1ftN_x37VTyvT6xf0133zYQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Please find my observation details below.

root@dm368-evm:/# free
              total         used         free       shared      buffers
  Mem:        76384        22876        53508            0         3436
 Swap:            0            0            0
Total:        76384        22876        53508


root@dm368-evm:/# aplay usr/share/sounds/alsa/Front_Left.wav
Playing WAVE 'usr/share/sounds/alsa/Front_Left.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono

root@dm368-evm:/# free
              total         used         free       shared      buffers
  Mem:        76384        23416        52968            0         3476
 Swap:            0            0            0
Total:        76384        23416        52968

root@dm368-evm:/# aplay usr/share/sounds/alsa/Front_Center.wav

root@dm368-evm:/# free
              total         used         free       shared      buffers
  Mem:        76384        23560        52824            0         3480
 Swap:            0            0            0
Total:        76384        23560        52824

root@dm368-evm:/# aplay usr/share/sounds/alsa/Side_Right.wav

root@dm368-evm:/# free
              total         used         free       shared      buffers
  Mem:        76384        23692        52692            0         3484
 Swap:            0            0            0
Total:        76384        23692        52692

Thank you,
Sreedhar.

On 11/4/11, Appalayagari Sreedhar <sreecha01@gmail.com> wrote:
> Hi,
>
> I am working with DM368 based custom board. we have external codec
> interfaced to McBSP.
> when we run aplay command i am observing memory leak.
>
> the leak is around 12k everytime i do aplay. if i get any underruns
> the leak is more than 12k
>
> the kernel version i am working is "Linux-2.6.32.17-davinci1".
>
> The codec driver is in alsa model.
> Could you please help to resolve this problem.
>
> Thanks in advance,
> Sreedhar.
>
