From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: How to show hda trace events in a self-built
	kernel?
Date: Wed, 23 Apr 2014 10:31:39 +0200
Message-ID: <53577A6B.2060400@canonical.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F82B3F4357@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B653261696
 for <alsa-devel@alsa-project.org>; Wed, 23 Apr 2014 10:31:45 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B3F4357@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 2014-04-23 09:35, Lin, Mengdong wrote:
> Hi,
>
> How to show hda trace events in a self-built kernel?
>
> With a self-built kernel under Ubuntu 13.04 or 13.10, I enabled hda
> trace events by
>
> #cd /sys/kernel/debug/tracing/
>
> #echo 1 > events/hda/enable
>
> #echo 1 > events/had_intel/enable
>
> Then I check the codec proc entry and run =93cat trace=94. But I got no
> output of the hda trace events.

Did you forget to do:
# echo 1 > tracing_on

You might also want to set current_tracer to something.

Otherwise I don't know what the problem can be.

-- =

David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
