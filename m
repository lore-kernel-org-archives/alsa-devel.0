From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] Add default config for tegra-alc5632 (as
 found on paz00)
Date: Mon, 06 Feb 2012 21:52:24 -0800
Message-ID: <4F30BC18.3040102@nvidia.com>
References: <1328561498-19337-1-git-send-email-fercerpav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328561498-19337-1-git-send-email-fercerpav@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Fertser <fercerpav@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patch@alsa-project.org" <patch@alsa-project.org>, Oliver Grawert <ogra@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

On 02/06/2012 12:51 PM, Paul Fertser wrote:
> This makes paz00 (aka Toshiba ac100, a popular arm-based netbook) use
> dmix/dsnoop by default since it doesn't support hw mixing.

This patch appears to match on card name being "tegra-alc5632", but the
device tree code that just got checked in will name the card "Compal
PAZ00" I believe. (and I believe this driver only supports DT not board
files) Am I missing something?

-- 
nvpublic
