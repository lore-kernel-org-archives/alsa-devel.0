From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin v2 0/2] jack: Support to connect
	multiple JACK ports with same ALSA channel
Date: Tue, 29 Jan 2019 15:30:54 +0100
Message-ID: <1548772256-30547-1-git-send-email-twischer@de.adit-jv.com>
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
To: tiwai@suse.de, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 1/29/19 14:45, Takashi Iwai wrote:
> name is already dereferenced in strlen(), so it's too late here.
> i.e. name_size has to be evaluated after this NULL check, if any.
> Or just drop this NULL check.  It's an internal function and the name
> is never NULL, practically seen.

I have removed it.

> name_size is the exact size of string + 1, so this is equivalent with
> strcpy().

I have added a comment and I am using strcpy(), now.

Best regards

Timo
