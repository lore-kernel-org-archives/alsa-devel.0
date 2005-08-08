From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [ALSA - driver 0001310]: Driver cant find firmware for Layla24
Date: Mon, 8 Aug 2005 21:04:47 +1200
Message-ID: <200508082104.47991.linux@audioscience.com>
References: <b1aafa7d69ffb16052ad659919fac4a8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <b1aafa7d69ffb16052ad659919fac4a8@bugtrack.alsa-project.org>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I may be completely off track here but...

I was caught out recently because FC4 for example expects firmware in a 
different directory than /usr/lib/hotplug (from memory /lib/firmware ?)

take a look at /etc/hotplug/firmware.agent, and see which path it is using to 
look for the firmware

-- Eliot


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
