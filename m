From: Ryan Pavlik <rpav@nwlink.com>
Subject: Similar problems here...
Date: Thu, 1 May 2003 22:14:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030501221404.109b9f5d.rpav@nwlink.com>
References: <20030501215702.27094.qmail@web40601.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030501215702.27094.qmail@web40601.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 1 May 2003 22:57:02 +0100 (BST)
Chris Rankin <rankincj@yahoo.com> wrote:

<snip>
> SNDRV_PCM_IOCTL_DROP failed: File descriptor in bad
> state
<snip>

I'm having a similar problem with CVS (from just now),
with mp1e:

mp1e:oss.c:81: Failed to read PCM data, 8192 bytes (77, File descriptor in bad state)

> This is on a Linux 2.4.20-SMP machine; glibc-2.3.2.

2.4.19-SMP here, ice1712, mtpav, and ymfpci drivers.  (ice1712 via
OSS is what's recording in this case, but same deal from ymfpci.)

-- 
Ryan Pavlik <rpav@users.sf.net>

"Green werewolves are a perfectly natural part of... uh
 nature. As are ghosts." - 8BT


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
