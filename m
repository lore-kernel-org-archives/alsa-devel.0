From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 13/22] docs: soundwire: locking: fix tags
 for a code-block
Date: Tue, 4 Jun 2019 10:12:52 -0500
Message-ID: <50782689-9cc1-9f4e-c2c0-23e6229cd2be@linux.intel.com>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
 <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@infradead.org>, Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 6/4/19 9:17 AM, Mauro Carvalho Chehab wrote:
> There's an ascii artwork at Example 1 whose code-block is not properly
> idented, causing those warnings.
> 
>      Documentation/driver-api/soundwire/locking.rst:50: WARNING: Inconsistent literal block quoting.
>      Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
>      Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
>      Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for fixing this.

> ---
>   Documentation/driver-api/soundwire/locking.rst | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/driver-api/soundwire/locking.rst b/Documentation/driver-api/soundwire/locking.rst
> index 253f73555255..3a7ffb3d87f3 100644
> --- a/Documentation/driver-api/soundwire/locking.rst
> +++ b/Documentation/driver-api/soundwire/locking.rst
> @@ -44,7 +44,9 @@ Message transfer.
>        b. Transfer message (Read/Write) to Slave1 or broadcast message on
>           Bus in case of bank switch.
>   
> -     c. Release Message lock ::
> +     c. Release Message lock
> +
> +     ::
>   
>   	+----------+                    +---------+
>   	|          |                    |         |
> 
