From: "Dan Nicholson" <dbn.lists@gmail.com>
Subject: Restore state around suspend/resume
Date: Sat, 29 Nov 2008 12:40:02 -0800
Message-ID: <91705d080811291240m506b4f7fj54f021411c5bd055__35135.6017440141$1228287882$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: pm-utils <pm-utils@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Currently, suspending the computer via pm-suspend (as done from HAL),
causes the ALSA state to be stored and restored via alsactl. Here's
what the hook looks like:

http://cgit.freedesktop.org/pm-utils/tree/pm/sleep.d/65alsa

Is this still necessary on recent kernels? Is there a list of drivers
which properly maintain state across suspend/resume? We're trying to
cut down on the amount of work done in userspace which slows down
suspend cycles.

Thanks.

--
Dan
