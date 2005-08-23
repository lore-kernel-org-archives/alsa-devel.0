From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DRS support for AC97
Date: Tue, 23 Aug 2005 09:43:46 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0508230936560.24395-100000@studcom.urz.uni-halle.de>
References: <430AC171.4060903@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <430AC171.4060903@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Philip Prindeville wrote:
> How much effort is involved in getting the AC97 to support
> DRS?

Change snd_ac97_set_rate and set_spdif_rate appropriately, make some
other changes to ensure that the data on slots 3+4 doesn't conflict
with the DAC output (except when the DACs output at the same sample
rate), change the controller driver(s) to adjust the hardware limits
appropriately, and then fix any bugs that I've overlooked.

> This might be a way to support 44.1kHz SPDIF playback (albeit
> upsampled to 88.2kHz).

Is there any codec that supports 88.2 but not 44.1?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
