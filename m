From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel][PATCH v2 1/3] xen: Introduce shared
 buffer helpers for page directory...
Date: Tue, 4 Dec 2018 19:28:05 -0500
Message-ID: <ab1b0d28-f3a1-41ec-82df-2474553dbefe@oracle.com>
References: <20181130074205.20496-1-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 02614267B88
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 01:28:17 +0100 (CET)
In-Reply-To: <20181130074205.20496-1-andr2000@gmail.com>
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
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, jgross@suse.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 11/30/18 2:42 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>
> based frontends. Currently the frontends which implement
> similar code for sharing big buffers between frontend and
> backend are para-virtualized DRM and sound drivers.
> Both define the same way to share grant references of a
> data buffer with the corresponding backend with little
> differences.
>
> Move shared code into a helper module, so there is a single
> implementation of the same functionality for all.
>
> This patch introduces code which is used by sound and display
> frontend drivers without functional changes with the intention
> to remove shared code from the corresponding drivers.
>
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Acked-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
