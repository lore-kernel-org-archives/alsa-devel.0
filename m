From: Tony Prisk <linux@prisktech.co.nz>
Subject: WM9712/WM9715 - WM97XXPENDOWN issue
Date: Tue, 8 Mar 2011 02:47:23 +0000
Message-ID: <76F764B079F92A4E843589C893D0A02201285D@SERVER.prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SERVER.prisktech.co.nz (ip-58-28-154-8.static-xdsl.xnet.co.nz
	[58.28.154.8]) by alsa0.perex.cz (Postfix) with ESMTP id 740D32440D
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 03:49:41 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have any issue with the WM9712 codec that I was hoping someone might be familiar with.



I actually have a Wondermedia WM8505 based netbook with the WM9715 codec - although it seems to be compatible with the WM9711/WM9712.



I have written the required ASoC support for this board/platform, and wm97xx battery support is working correctly except for one issue.



Touchscreen support is required, but not available on this unit (not really an issue outright, but the cause of the problem).

Without removing the following code, wm9712_poll_sample always fails when reading the battery ADC.



static int wm9712_poll_sample(struct wm97xx *wm, int adcsel, int *sample) ...

        /* check we have correct sample */

        if ((*sample & WM97XX_ADCSEL_MASK) != adcsel) {

                dev_dbg(wm->dev, "adc wrong sample, read %x got %x", adcsel,

                *sample & WM97XX_ADCSEL_MASK);

                return RC_PENUP;

        }

/* <--- PROBLEM CODE HERE --->

        if (!(*sample & WM97XX_PEN_DOWN)) {

                wm->pen_probably_down = 0;

                return RC_PENUP;

        }

*/

        return RC_VALID;

}



Is it possible that with no touchscreen attached, the codec is returning WM97XX_PEN_DOWN on all ADC reads?



Any suggestions welcome.





Tony Prisk
