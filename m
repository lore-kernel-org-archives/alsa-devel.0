From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - ALSA JACK plugin 1/2] jack: Replacing
 jack->channels with jack->num_ports
Date: Fri, 11 Jan 2019 08:53:17 +0100
Message-ID: <df4d8f44-ff0f-31eb-b7f2-a466f2d5a3f6@perex.cz>
References: <1547183755-3551-1-git-send-email-laxmi.devi@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1547183755-3551-1-git-send-email-laxmi.devi@in.bosch.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: laxmi.devi@in.bosch.com, patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 11.1.2019 v 06:15 laxmi.devi@in.bosch.com napsal(a):
> From: Laxmi Devi <Laxmi.Devi@in.bosch.com>
> 
> As jack->num_ports and jack->channels hold the same values,
> jack->channels is redundant and hence removed.
> 
> Sanity check is added in prepare, to check if io->Channels is
> same as jack->num_ports.

I applied both patches to the plugins repo. Thanks.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
