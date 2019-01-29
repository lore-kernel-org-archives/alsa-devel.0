From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Tue, 29 Jan 2019 12:36:06 +0900
Message-ID: <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
References: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
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
To: pmalani@chromium.org, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, derat@chromium.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 2019/01/29 10:44, pmalani@chromium.org wrote:
> @@ -775,6 +780,11 @@ int main(int argc, char *argv[])
> +		case 'n':
> +			num_events = atoi(optarg);
> +			if (num_events <= 0)
> +				fatal("num_events must be greater than 0");
> +			break;

We cannot distinguish two cases; 0 is given and including non-numeraical
characters. Please use strtol() or so and check return value and errno
for safe.

For your information:
http://git.alsa-project.org/?p=alsa-utils.git;a=blob;f=axfer/main.c;hb=HEAD#l44


Regards

Takashi Sakamoto
