From: Manuel Lauss <manuel.lauss@gmail.com>
Subject: ASoC: please revert "ASoC: db1200: Use static DAI
	format setup"
Date: Sun, 6 Sep 2015 19:32:02 +0200
Message-ID: <CAOLZvyG_tgPoXFJMBkqSeDULBUzgdqnNjQF7eVuzLzU2VtDArg@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Lars,

commit b4508d0f95fa4aaed889549e31391641d675d4bb
("ASoC: db1200: Use static DAI format setup") breaks I2S in that the
set_dai_fmt() callbacks of neither the codec (wm8731) nor the I2S block
(psc-i2s) are called.

Please revert this change or fix it up so that the set_dai_fmt() callbacks
are at least called once. (This was broken since 4.0, but I just now got
around to test linux on the hardware again).

Thanks!
       Manuel
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
