From: Thomas Charbonnel <thomas@undata.org>
Subject: ctl api questions
Date: 11 Mar 2003 10:04:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1047373458.1906.13.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

As you may know the hdsp has a variable number of channels depending on
the sample rate. The card's internal routing is controlled by a matrix
mixer. For convenience simple mixer ctls are defined at card
initialization. When the number of channels change, I flag the .access
field of the unused ctls with SNDRV_CTL_ELEM_READ and
SNDRV_CTL_ELEM_INACTIVE. It seems to work fine with amixer (amixer
controls doesn't show anymore the unused channels), but alsamixer gives
the following error: function snd_mixer_load failed: Invalid argument.
Any idea on what is going wrong ? 

Another point: the matrix mixer is now (with patch II from Paul)
read/write. In write mode it takes 3 parameters:
source,destination,gain. With the amixer patch I submitted some days ago
it is possible to actually read it, passing source and destination
channels as parameters to the cget option. In the driver, the return
values use the same structure as the parameters. Should I respect the
parameters index (returning the gain value in value[2]) or should I
consider that return values start at value[0] ?

Thomas




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
