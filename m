From: Peter Heatwole <peter599@gotnet.net>
Subject: Re: [PATCH] cs46xx, independant rear PCM channel, IEC958 PCM channel
Date: Tue, 29 Oct 2002 07:14:56 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021029151456.GA776@porky>
References: <3DBE3EDA.80900@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3DBE3EDA.80900@cucumelo.org>; from gorm@cucumelo.org on Mon, Oct 28, 2002 at 23:55:06 -0800
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 2002.10.28 23:55 Benny Sjostrand wrote:
> I've got some reports that stuffs dont seems to work very well with
> the Santa Cruz card, course for some unknown reason the driver dont
> manage to raise GPIO 7 and 9 on the secondary codec that
> enables the rear output, you probably will see the message
> "cs46xx_setup_eapd_slot() Failure to write the GPIO pins for
> slot 12. " and that will probably freeze you computer
> for a while too.


    I should clarify that the freezing only happened while I was
testing the driver by removing the GPIO write-complete check. This
caused the function to be called multiple times in a row, which was
what caused the temporary freeze.  I've had no problems with freezing
with the current driver.   (So don't let that statement scare you.)  ;-)

-- Peter Heatwole
"Murphy was just a well known pessimist."



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
