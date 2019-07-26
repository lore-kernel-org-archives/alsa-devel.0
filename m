From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 21/40] soundwire: export helpers to find
 row and column values
Date: Fri, 26 Jul 2019 10:26:01 -0500
Message-ID: <d6268a75-b38c-aee5-0463-af8b602286bb@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-22-pierre-louis.bossart@linux.intel.com>
 <20190726144325.GH16003@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190726144325.GH16003@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org



On 7/26/19 9:43 AM, Guennadi Liakhovetski wrote:
> On Thu, Jul 25, 2019 at 06:40:13PM -0500, Pierre-Louis Bossart wrote:
>> Add a prefix for common tables and export 2 helpers to set the frame
>> shapes based on row/col values.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus.h    |  7 +++++--
>>   drivers/soundwire/stream.c | 14 ++++++++------
>>   2 files changed, 13 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
>> index 06ac4adb0074..c57c9c23f6ca 100644
>> --- a/drivers/soundwire/bus.h
>> +++ b/drivers/soundwire/bus.h
>> @@ -73,8 +73,11 @@ struct sdw_msg {
>>   
>>   #define SDW_DOUBLE_RATE_FACTOR		2
>>   
>> -extern int rows[SDW_FRAME_ROWS];
>> -extern int cols[SDW_FRAME_COLS];
>> +extern int sdw_rows[SDW_FRAME_ROWS];
>> +extern int sdw_cols[SDW_FRAME_COLS];
> 
> So these arrays actually have to be exported? In the current (5.2) sources they
> seem to only be used in stream.c, maybe make them static there?
> 
>> +
>> +int sdw_find_row_index(int row);
>> +int sdw_find_col_index(int col);

yes, they need to be exported, they are used by the allocation algorithm 
(in Patch 27).
Others will need this for non-Intel solutions, it's really a part of the 
standard definition and should be shared.
I can improve the commit message to make this explicit.
